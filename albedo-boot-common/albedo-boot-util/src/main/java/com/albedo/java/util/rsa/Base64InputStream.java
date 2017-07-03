package com.albedo.java.util.rsa;

import java.io.IOException;
import java.io.InputStream;

public class Base64InputStream
        extends InputStream {
    private InputStream inputStream;
    private int[] buffer;
    private int bufferCounter = 0;
    private boolean eof = false;

    public Base64InputStream(InputStream paramInputStream) {
        this.inputStream = paramInputStream;
    }

    public int read()
            throws IOException {
        if ((this.buffer == null) || (this.bufferCounter == this.buffer.length)) {
            if (this.eof) {
                return -1;
            }
            acquire();
            if (this.buffer.length == 0) {
                this.buffer = null;
                return -1;
            }
            this.bufferCounter = 0;
        }
        return this.buffer[(this.bufferCounter++)];
    }

    private void acquire()
            throws IOException {
        char[] arrayOfChar = new char[4];
        int i = 0;
        int k;
        do {
            int j = this.inputStream.read();
            if (j == -1) {
                if (i != 0) {
                    throw new IOException("Bad base64 stream");
                }
                this.buffer = new int[0];
                this.eof = true;
                return;
            }
            k = (char) j;
            if ((Shared.chars.indexOf(k) != -1) || (k == Shared.pad)) {
                arrayOfChar[(i++)] = (char) k;
            } else if ((k != 13) && (k != 10)) {
                throw new IOException("Bad base64 stream");
            }
        } while (i < 4);
        int j = 0;
        for (i = 0; i < 4; i++) {
            if (arrayOfChar[i] != Shared.pad) {
                if (j != 0) {
                    throw new IOException("Bad base64 stream");
                }
            } else if (j == 0) {
                j = 1;
            }
        }
        if (arrayOfChar[3] == Shared.pad) {
            if (this.inputStream.read() != -1) {
                throw new IOException("Bad base64 stream");
            }
            this.eof = true;
            if (arrayOfChar[2] == Shared.pad) {
                k = 1;
            } else {
                k = 2;
            }
        } else {
            k = 3;
        }
        int m = 0;
        for (i = 0; i < 4; i++) {
            if (arrayOfChar[i] != Shared.pad) {
                m |= Shared.chars.indexOf(arrayOfChar[i]) << 6 * (3 - i);
            }
        }
        this.buffer = new int[k];
        for (i = 0; i < k; i++) {
            this.buffer[i] = (m >>> 8 * (2 - i) & 0xFF);
        }
    }

    public void close()
            throws IOException {
        this.inputStream.close();
    }
}
