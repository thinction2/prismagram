/*
  Warnings:

  - The migration will change the primary key for the `Room` table. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Message" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "fromId" TEXT NOT NULL,
    "toId" TEXT NOT NULL,
    "roomId" TEXT NOT NULL,

    FOREIGN KEY ("fromId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("toId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY ("id")
);
INSERT INTO "new_Message" ("id", "text", "fromId", "toId", "roomId") SELECT "id", "text", "fromId", "toId", "roomId" FROM "Message";
DROP TABLE "Message";
ALTER TABLE "new_Message" RENAME TO "Message";
CREATE TABLE "new_Room" (
    "id" TEXT NOT NULL,
    PRIMARY KEY ("id")
);
INSERT INTO "new_Room" ("id") SELECT "id" FROM "Room";
DROP TABLE "Room";
ALTER TABLE "new_Room" RENAME TO "Room";
CREATE TABLE "new__RoomToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    FOREIGN KEY ("A") REFERENCES "Room"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new__RoomToUser" ("A", "B") SELECT "A", "B" FROM "_RoomToUser";
DROP TABLE "_RoomToUser";
ALTER TABLE "new__RoomToUser" RENAME TO "_RoomToUser";
CREATE UNIQUE INDEX "_RoomToUser_AB_unique" ON "_RoomToUser"("A", "B");
CREATE INDEX "_RoomToUser_B_index" ON "_RoomToUser"("B");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
