import express from "express";
import cors from "cors";
import prisma from "./db.js";

const app = express();
app.use(express.json());
app.use(cors());

const port = process.env.PORT || 4500;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.get("/api/get-all", cors(), async (req, res) => {
  const report = await prisma.report.findMany({
    include: {
      insights: true,
      tags: true,
      WikiLinks: true,
    },
  });
  console.log(report);
  res.json({ message: report });
});
// create a new record
app.post("/api/create", async (req, res) => {
  const { title, content, summary } = req.body;
  // post request to create a new report

  const report = await prisma.report.create({
    data: {
      title: title,
      content: content,
      summary: summary,
      lang: "en",
      author: "Krishna",
      generator: "Krishna",
    },
  });
  console.log(report);
  res.json({ message: report });
});

// retrieve data based on id
app.post("/api/get-report", async (req, res) => {
  const { id } = req.body;
  // post request to create a new report

  const report = await prisma.report.findUnique({
    where: {
      id,
    },
    include: {
      insights: true,
      tags: true,
      WikiLinks: true,
    },
  });
  console.log(report);
  res.json({ message: report });
});

app.post("/api/add-insights", async (req, res) => {
  const { insight, reportId } = req.body;
  // post request to create a new report

  const createInsight = await prisma.insights.create({
    data: {
      insight,
      reportId,
    },
  });
  console.log(createInsight);
  res.json({ message: createInsight });
});

// Create Wiki Links
app.post("/api/create-wiki", async (req, res) => {
  const { name, link, reportId } = req.body;
  const wiki = await prisma.wikilinks.create({
    data: {
      name,
      link,
      reportId,
    },
  });
  console.log(wiki);

  res.json({ message: wiki });
});

// Create Tags
app.post("/api/create-tags", async (req, res) => {
  const { tag, reportId } = req.body;
  const createtag = await prisma.tags.create({
    data: {
      tag,
      reportId,
    },
  });
  console.log(createtag);

  res.json({ message: createtag });
});

// // Add in Tags and Wiki Links
app.post("/api/addin-helper", async (req, res) => {
  const { entityLinking, namedEntites, id } = req.body;
  console.log(entityLinking, namedEntites);
  for (let i = 0; i < entityLinking.length; i++) {
    const { name, url } = entityLinking[i];
    const wiki = await prisma.wikilinks.create({
      data: {
        name,
        link: url,
        reportId: id,
      },
    });

    console.log(wiki);
  }
  for (let i = 0; i < namedEntites.length; i++) {
    const { text } = namedEntites[i];
    const createtag = await prisma.tags.create({
      data: {
        tag: text,
        reportId: id,
      },
    });
    console.log(createtag);
  }
  res.json({ message: "success" });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
