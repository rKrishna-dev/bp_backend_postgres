/*
  Warnings:

  - Added the required column `author` to the `Report` table without a default value. This is not possible if the table is not empty.
  - Added the required column `generator` to the `Report` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "author" TEXT NOT NULL,
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "generator" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Tags" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER,
    "tag" TEXT NOT NULL,

    CONSTRAINT "Tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WikiLinks" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER,
    "link" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "WikiLinks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Tags_id_key" ON "Tags"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Tags_reportId_key" ON "Tags"("reportId");

-- CreateIndex
CREATE UNIQUE INDEX "WikiLinks_id_key" ON "WikiLinks"("id");

-- CreateIndex
CREATE UNIQUE INDEX "WikiLinks_reportId_key" ON "WikiLinks"("reportId");

-- AddForeignKey
ALTER TABLE "Tags" ADD CONSTRAINT "Tags_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiLinks" ADD CONSTRAINT "WikiLinks_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;
