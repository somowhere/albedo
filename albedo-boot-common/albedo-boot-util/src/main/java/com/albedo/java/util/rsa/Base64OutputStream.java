package com.albedo.java.util.rsa;

import java.io.IOException;
import java.io.OutputStream;

public class Base64OutputStream
        extends OutputStream {
    private OutputStream outputStream = null;
    private int buffer = 0;
    private int bytecounter = 0;
    private int linecounter = 0;
    private int linelength = 0;

    public Base64OutputStream(OutputStream paramOutputStream) {
        this(paramOutputStream, 76);
    }

    public Base64OutputStream(OutputStream paramOutputStream, int paramInt) {
        this.outputStream = paramOutputStream;
        this.linelength = paramInt;
    }

    public void write(int paramInt)
            throws IOException {
        int i = (paramInt & 0xFF) << 16 - this.bytecounter * 8;
        this.buffer |= i;
        this.bytecounter += 1;
        if (this.bytecounter == 3) {
            commit();
        }
    }

    public void close()
            throws IOException {
        commit();
        this.outputStream.close();
    }

    protected void commit()
            throws IOException {
        if (this.bytecounter > 0) {
            if ((this.linelength > 0) && (this.linecounter == this.linelength)) {
                this.outputStream.write("\r\n".getBytes());
                this.linecounter = 0;
            }
            int i = Shared.chars.charAt(this.buffer << 8 >>> 26);
            int j = Shared.chars.charAt(this.buffer << 14 >>> 26);
            int k = this.bytecounter < 2 ? Shared.pad : Shared.chars.charAt(this.buffer << 20 >>> 26);
            int m = this.bytecounter < 3 ? Shared.pad : Shared.chars.charAt(this.buffer << 26 >>> 26);
            this.outputStream.write(i);
            this.outputStream.write(j);
            this.outputStream.write(k);
            this.outputStream.write(m);
            this.linecounter += 4;
            this.bytecounter = 0;
            this.buffer = 0;
        }
    }
}
