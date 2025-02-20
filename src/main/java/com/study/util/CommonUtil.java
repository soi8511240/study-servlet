package com.study.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CommonUtil {

    public static String formatWithComma(int num) {
        return String.format("%,d", num);
    }

    public static String dateFormat(Calendar calendar) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        return simpleDateFormat.format(calendar.getTime());
    }

    public static String getToday() {
        Calendar calendar = Calendar.getInstance();

        return dateFormat(calendar);
    }

    public static String getOneYearAgo() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, -1);

        return dateFormat(calendar);
    }

}
