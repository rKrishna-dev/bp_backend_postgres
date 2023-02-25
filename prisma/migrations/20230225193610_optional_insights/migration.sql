/*
  Warnings:

  - A unique constraint covering the columns `[reportId]` on the table `Insights` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Insights_reportId_key" ON "Insights"("reportId");
