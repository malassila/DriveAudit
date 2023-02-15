package com.pcsp.diskauditfx.messages;

import com.pcsp.driveauditfx.server.socket.ServerSideSocket;
import com.pcsp.driveauditfx.shared.device.DriveServer;

public interface Message {
    String getType();
    String getMessage();
    DriveServer getServer();
    String[] splitMessage(String message);
    String getSlot();
    String getCommand();
    String getSerialNumber();


    void processRawMessage(String message, ServerSideSocket serverSideSocket);

}
