/*
  Warnings:

  - You are about to drop the `WikiLinks` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "WikiLinks" DROP CONSTRAINT "WikiLinks_reportId_fkey";

-- DropTable
DROP TABLE "WikiLinks";

-- CreateTable
CREATE TABLE "Wikilinks" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER,
    "link" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Wikilinks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Wikilinks_id_key" ON "Wikilinks"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Wikilinks_reportId_key" ON "Wikilinks"("reportId");

-- AddForeignKey
ALTER TABLE "Wikilinks" ADD CONSTRAINT "Wikilinks_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;
