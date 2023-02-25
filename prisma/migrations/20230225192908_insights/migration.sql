-- CreateTable
CREATE TABLE "Insights" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER,
    "insight" TEXT NOT NULL,

    CONSTRAINT "Insights_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Insights_id_key" ON "Insights"("id");

-- AddForeignKey
ALTER TABLE "Insights" ADD CONSTRAINT "Insights_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE SET NULL ON UPDATE CASCADE;
