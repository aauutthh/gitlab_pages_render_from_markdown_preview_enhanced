#!/usr/bin/env node

// es6
// import * as mume from "@shd101wyy/mume"
const mume = require("@shd101wyy/mume");
const path = require("path");
const os = require("os");
const glob = require("glob");
const { promises: fs } = require("fs");

async function main() {
  const configPath = path.resolve(os.homedir(), ".mume"); // use here your own config folder, default is "~/.mume"
  await mume.init(configPath); // default uses "~/.mume"

  workingDir = process.argv[2]
  ouputDir = process.argv[3]
  const globPromises = glob.sync(path.join(workingDir, '/**/*.md'), { nodir: true }).map(async (filePath) => {
    console.log(filePath)
    let engine = new mume.MarkdownEngine({
      filePath: filePath,
      config: {
        configPath: configPath,
        previewTheme: "github-light.css",
        // revealjsTheme: "white.css"
        codeBlockTheme: "default.css",
        printBackground: true,
        enableScriptExecution: true, // <= for running code chunks
      },
    });
    // html export
    await engine.htmlExport({ offline: true, runAllCodeChunks: true });

    if (ouputDir) {
      let htmlPath = filePath.replace(/\.[^.]+$/, '.html');
      let htmlRelPath = path.relative(workingDir, htmlPath)
      let outputPath = path.join(ouputDir, htmlRelPath)
      await fs.mkdir(path.dirname(outputPath), { recursive: true })
      await fs.copyFile(htmlPath, outputPath, async (err) => {
        if(err) console.log(err);
      });
      
    }
  })

  await Promise.all(globPromises);

  return process.exit();
}

main();
