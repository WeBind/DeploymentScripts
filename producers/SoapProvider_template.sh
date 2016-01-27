#!/bin/bash
NAME=$1

cat << EOF
package example;

import javax.annotation.Resource;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.servlet.ServletContext;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebService(serviceName = "provider-$NAME")
public class SoapProvider$NAME {
    Logger lg = java.util.logging.Logger.getLogger("SoapProducer");

    private static WebServiceContext WSC;

    @WebMethod(exclude = true)
    @Resource
    public void setContext(WebServiceContext context) {
        String n = "Not null";
        if(context == null) n = "context null";
        lg.log(Level.INFO, "Updating WSS context " + n);
        WSC = context;
    }

    /**
     * Run the service, according to the configuration
     */
    @WebMethod()
    public byte[] doStuff() throws InterruptedException {
        WebServiceContext wsc = WSC;
        lg.log(Level.INFO, "wsc ? " + (wsc == null));

        MessageContext msgCtx = wsc.getMessageContext();
        lg.log(Level.INFO, "msgCtx ? " + (msgCtx == null));

        ServletContext ctx = (ServletContext) msgCtx.get(MessageContext.SERVLET_CONTEXT);

        String number = (String) ctx.getAttribute(Config.NUMBER);

        lg.log(Level.INFO, "[" + number + "] Doing stuff - delay:" + ctx.getAttribute(Config.CONFIG_DELAY));
        byte[] mess;
        long time2,
            time = System.currentTimeMillis();

        int delay = Integer.parseInt(
                ctx.getAttribute(Config.CONFIG_DELAY) != null ? ctx.getAttribute(Config.CONFIG_DELAY).toString() : "0"),
            messageSize = Integer.parseInt(
                ctx.getAttribute(Config.CONFIG_MSG_SIZE) != null ? ctx.getAttribute(Config.CONFIG_MSG_SIZE).toString() : "10");

        mess = generateMessage(messageSize);

        time2 = System.currentTimeMillis();
        long sleepingtime = delay - (time2 - time);
        lg.log(Level.INFO, "[" + number + "] Sleeping " + sleepingtime);
        Thread.sleep(Math.max(0, sleepingtime));

        return mess;
    }



    /**
     * Configures the WebService
     * @param messageSize   size of the answer message
     * @param delay         delay before the service responds
     */
    @WebMethod()
    public String configure(int messageSize, int delay) {
        MessageContext msgCtx = WSC.get().getMessageContext();
        ServletContext ctx = (ServletContext) msgCtx.get(MessageContext.SERVLET_CONTEXT);
        ctx.setAttribute(Config.CONFIG_DELAY, delay);
        ctx.setAttribute(Config.CONFIG_MSG_SIZE, messageSize);

        return "OK";
    }




    private byte[] generateMessage(int messageSize) {
        byte[] mess = new byte[messageSize];
        for(int i=0;i < messageSize;i++) {
            mess[i] =(byte) ('a' +(i%26));
        }
        return mess;
    }

}
EOF