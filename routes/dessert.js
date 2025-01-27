const router = require("express").Router();
const User = require("../models/user");
const Dessert = require("../models/dessert");
const { authenticateToken } = require("./userAuth");

// Add a new dessert
router.post("/add-dessert", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers; // Assuming 'id' is the user ID passed in the headers

    // const user = await User.findById(id);
    // Uncomment if you need admin access control
    // if (user.role !== "admin") {
    //   return res.status(400).json({ message: "You don't have access to perform this task" });
    // }

    const dessert = new Dessert({
      url: req.body.url,
      title: req.body.title,
      shopName: req.body.shopName,
      price: req.body.price,
      desc: req.body.desc,
      uploader_id: id, // Use the authenticated user ID as the uploader_id
      category: req.body.category, // Reference to category
      stock: req.body.stock, // New field for stock
    });

    await dessert.save();
    res.status(200).json({ message: "Dessert added successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// Update dessert
router.put("/update-dessert", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers; // Authenticated user's ID
    const { dessertId } = req.headers;

    const dessert = await Dessert.findById(dessertId);

    if (!dessert) {
      return res.status(404).json({ message: "Dessert not found" });
    }

    // Check if the user updating the dessert is the uploader or admin
    if (dessert.uploader_id !== id /* && user.role !== "admin" */) {
      return res
        .status(403)
        .json({ message: "You don't have permission to update this dessert" });
    }

    await Dessert.findByIdAndUpdate(dessertId, {
      url: req.body.url,
      title: req.body.title,
      shopName: req.body.author,
      price: req.body.price,
      desc: req.body.desc,
      category: req.body.category, // Updated field
      stock: req.body.stock, // Updated field for stock
    });

    return res.status(200).json({
      message: "Dessert updated successfully!",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Delete dessert
router.delete("/delete-dessert", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers; // Authenticated user's ID
    const { dessertId } = req.headers;

    const dessert = await Dessert.findById(dessertId);

    if (!dessert) {
      return res.status(404).json({ message: "Dessert not found" });
    }

    // Check if the user deleting the dessert is the uploader or admin
    if (dessert.uploader_id !== id /* && user.role !== "admin" */) {
      return res
        .status(403)
        .json({ message: "You don't have permission to delete this dessert" });
    }

    await Dessert.findByIdAndDelete(dessertId);

    return res.status(200).json({
      message: "Dessert deleted successfully!",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Get all desserts
router.get("/get-all-desserts", async (req, res) => {
  try {
    const desserts = await Dessert.find()
      .populate("category")
      .sort({ createdAt: -1 });
    return res.json({
      status: "Success",
      data: desserts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Get recently added desserts, limit 4
router.get("/get-recent-desserts", async (req, res) => {
  try {
    const desserts = await Dessert.find()
      .populate("category")
      .sort({ createdAt: -1 })
      .limit(4);
    return res.json({
      status: "Success",
      data: desserts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Get dessert by ID
router.get("/get-dessert-by-id/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const dessert = await Dessert.findById(id).populate("category");
    if (!dessert) {
      return res.status(404).json({ message: "Dessert not found" });
    }
    return res.json({
      status: "Success",
      data: dessert,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Get desserts uploaded by user
router.get("/get-desserts-by-uploader", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers; // Authenticated user's ID

    // Find desserts where the uploader_id matches the authenticated user
    const desserts = await Dessert.find({ uploader_id: id })
      .populate("category")
      .sort({ createdAt: -1 });

    return res.status(200).json({
      status: "Success",
      data: desserts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Get desserts by category (by category name or category ID)
router.get("/get-desserts-by-category", async (req, res) => {
  try {
    const { category } = req.headers;

    // Find desserts where the 'category' matches the provided category (name or ID)
    const desserts = await Dessert.find({ category })
      .populate("category")
      .sort({ createdAt: -1 });

    if (desserts.length === 0) {
      return res.status(404).json({
        status: "Failure",
        message: "No desserts found for this category",
      });
    }

    return res.status(200).json({
      status: "Success",
      data: desserts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Search for desserts by a search value (title, author, or description)
router.get("/search-desserts", async (req, res) => {
  try {
    const { search } = req.query; // Get the search value from the query parameters

    if (!search) {
      return res.status(400).json({
        status: "Failure",
        message: "Search value is required",
      });
    }

    // Search desserts where the title, author, or description contains the search value
    const desserts = await Dessert.find({
      $or: [
        { title: { $regex: search, $options: "i" } }, // Case-insensitive search
        { author: { $regex: search, $options: "i" } },
        { desc: { $regex: search, $options: "i" } },
      ],
    })
      .populate("category")
      .sort({ createdAt: -1 });

    if (desserts.length === 0) {
      return res.status(404).json({
        status: "Failure",
        message: "No desserts found matching the search criteria",
      });
    }

    return res.status(200).json({
      status: "Success",
      data: desserts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

module.exports = router;
