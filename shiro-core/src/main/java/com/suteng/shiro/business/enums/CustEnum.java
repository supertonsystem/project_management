package com.suteng.shiro.business.enums;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 16:15 2019/5/17
 */
public class CustEnum {
   public static enum SEX {
        MAN("男"),
        WOMAN("女"),
        UNKNOW("未知");

        private String sex;

        SEX(String sex) {
            this.sex = sex;
        }

        /**
         * 根据类型的下标，返回类型的枚举实例。
         *
         * @param ordinal 类型名称
         */
        public static SEX get(Integer ordinal) {
            if (null == ordinal) {
                return UNKNOW;
            }
            SEX[] enums = SEX.values();
            for (SEX enenum: enums) {
                if (enenum.ordinal()==ordinal) {
                    return enenum;
                }
            }
            return UNKNOW;
        }

        public String sexName(){
            return this.sex;
        }
    }

    public static  enum CREDIT {
        EXCELLENT("优秀"),
        WELL("良好"),
        COMMON("一般"),
        BAD("较差"),
        UNKNOW("未知");

        private String credit;

        CREDIT(String credit) {
            this.credit = credit;
        }

        /**
         * 根据类型的下标，返回类型的枚举实例。
         *
         * @param ordinal 类型名称
         */
        public static CREDIT get(Integer ordinal) {
            if (null == ordinal) {
                return UNKNOW;
            }
            CREDIT[] enums = CREDIT.values();
            for (CREDIT enenum: enums) {
                if (enenum.ordinal()==ordinal) {
                    return enenum;
                }
            }
            return UNKNOW;
        }

        public String creditName(){
            return this.credit;
        }
    }
}
