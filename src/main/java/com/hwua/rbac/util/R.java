package com.hwua.rbac.util;

import java.util.HashMap;
/*
    自定义工具类尽量减少第三方依赖
 */
public class R extends HashMap<String,Object> {
    private R(){
        put("code",1);
        put("message","操作成功");
    }

    public static R ok(){
        return new R();
    }

    public static R ok(Object object){
        R r = new R();
        r.put("object",object);
        return r;
    }

    public static R error(){
        return R.error(0,"操作失败");
    }

    public static R error(int code,String message){
        R r = new R();
        r.put("code",code);
        r.put("message",message);
        return r;
    }
}
