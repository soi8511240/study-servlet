package com.study.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DateUtil {

    public static String getToday() {
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy-MM-dd");

        return simpleDateFormat.format(calendar.getTime());
    }

    public static String getOneYearAgo() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, -1);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy-MM-dd");
        return simpleDateFormat.format(calendar.getTime());
    }
}
