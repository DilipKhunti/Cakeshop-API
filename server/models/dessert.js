const mongoose = require("mongoose");

const dessertSchema = new mongoose.Schema(
  {
    url: {
      type: String,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    shopName: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    desc: {
      type: String,
      required: true,
    },
    uploader_id: {
      type: String,
      required: true,
    },
    category: {
      type: mongoose.Types.ObjectId, // Reference to the Category schema
      ref: "category", // Model name to reference
      required: true, // Make it required
    },
    stock: {
      type: Number,
      required: true, // Making stock required
      min: 0, // Ensuring stock cannot be negative
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("dessert", dessertSchema);
