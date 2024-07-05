// import { ChatGoogleGenerativeAI } from "@langchain/google-genai";

// const model = new ChatGoogleGenerativeAI({
//   model: "gemini-pro",
//   temperature: 0,
//   // topK,
//   // apiKey: "AIzaSyBJirMR92ffYppxOLehzIFaNvOUn5mYo",
// });

// const res = await model.invoke([
//   [
//     "human",
//     "What would be a good company name for a company that makes colorful socks?",
//   ],
// ]);
import fs from "fs";
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI("AIzaSyDNz2PSrQm5MYzP4DKUAqnq7LAdAZfh9ds");

function fileToGenerativePart(path, mimeType) {
  return {
    inlineData: {
      data: Buffer.from(fs.readFileSync(path)).toString("base64"),
      mimeType,
    },
  };
}

const filePart1 = fileToGenerativePart(
  "../../../../Downloads/guy.jpg",
  "image/jpeg"
);

const filePart2 = fileToGenerativePart(
  "../../../../Downloads/moldova.png",
  "image/jpeg"
);

async function run() {
  const model = genAI.getGenerativeModel({
    model: "gemini-1.5-pro",
    generationConfig: { temperature: 0.2 },
  });

  const prompt = `I need to scrape some images from news websites and find similar photos on the internet. Here are the steps:
    The first image(s) provided are the photos I want to change.
    The last image will be a screenshot from a Google Images search based on a text.
    Gemini should compare the first image(s) with the images in the last screenshot.
    If similar images are found in the last screenshot, describe the position of each similar photo. Please avoid duplicates!
    If no similar images are found, respond with: "No proper image".`;

  const imageParts = [filePart1, filePart2];

  const generatedContent = await model.generateContent([prompt, ...imageParts]);

  console.log(generatedContent.response.text());
}

run();
