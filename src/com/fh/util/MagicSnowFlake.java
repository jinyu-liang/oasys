package com.fh.util;


/**
 * @author zcl
 * @date 2017/7/12
 **/
public class MagicSnowFlake {

    //其实时间戳   2017-01-01 00:00:00
    private final static long twepoch = 1483200000000l;

    //10bit（位）的工作机器id  中IP标识所占的位数 8bit（位）
    private final static long ipIdBits = 8L;

    //IP标识最大值 255  即2的8次方减一。
    private final static long ipIdMax = ~ (-1L << ipIdBits);

    //10bit（位）的工作机器id  中数字标识id所占的位数 2bit（位）
    private final static long dataCenterIdBits = 2L;

    //数字标识id最大值 3  即2的2次方减一。
    private final static long dataCenterIdMax = ~ (-1L << dataCenterIdBits);

    //序列在id中占的位数 12bit
    private final static long seqBits = 12L;

    //序列最大值 4095 即2的12次方减一。
    private final static long seqMax = ~(-1L << seqBits);

    // 64位的数字：首位0  随后41位表示时间戳 随后10位工作机器id（8位IP标识 + 2位数字标识） 最后12位序列号
    private final static long dataCenterIdLeftShift = seqBits;
    private final static long ipIdLeftShift = seqBits + dataCenterIdBits;
    private final static long timeLeftShift = seqBits  + dataCenterIdBits + ipIdLeftShift;

    //IP标识(0~255)
    private long ipId;

    // 数据中心ID(0~3)
    private long dataCenterId;

    // 毫秒内序列(0~4095)
    private long seq = 0L;

    // 上次生成ID的时间截
    private long lastTime = -1L;

    public MagicSnowFlake(long ipId, long dataCenterId) {
        if(ipId < 0 || ipId > ipIdMax) {
            System.out.println(" ---------- ipId不在正常范围内(0~"+ipIdMax +") " + ipId);
            System.exit(0);
        }

        if(dataCenterId < 0 || dataCenterId > dataCenterIdMax) {
            System.out.println(" ---------- dataCenterId不在正常范围内(0~"+dataCenterIdMax +") " + dataCenterId);
            System.exit(0);
        }

        this.ipId = ipId;
        this.dataCenterId = dataCenterId;
    }

    public synchronized long nextId() {
        long nowTime = System.currentTimeMillis();

        if(nowTime < lastTime) {
            System.out.println(" ---------- 当前时间前于上次操作时间，当前时间有误: " + nowTime);
            System.exit(0);
        }

        if(nowTime == lastTime) {
            seq = (seq + 1) & seqMax;
            if(seq == 0) {
                nowTime = getNextTimeStamp();
            }
        } else {
            seq = 0L;
        }

        lastTime = nowTime;

        return ((nowTime - twepoch) << timeLeftShift)
                | (ipId << ipIdLeftShift)
                | (dataCenterId << dataCenterIdLeftShift)
                | seq;
    }

    private long getNextTimeStamp() {
        long nowTime;
        do {
            nowTime = System.currentTimeMillis();
        } while(nowTime <= lastTime);
        return nowTime;
    }
    
    public static void main(String[] args) {

        MagicSnowFlake msf = new MagicSnowFlake(196, 2);
      System.out.println(msf.nextId());
    }
}

