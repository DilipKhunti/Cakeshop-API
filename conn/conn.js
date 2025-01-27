require("dotenv").config();
const mongoose = require("mongoose");

// Connecting to database
const conn = async () => {
  try {
    await mongoose.connect(process.env.URI, {});
    console.log("Database connected");
  } catch (error) {
    console.log("Database connection error:", error);
  }
};
conn();
