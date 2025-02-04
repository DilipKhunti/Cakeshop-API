const router = require("express").Router();
const Category = require("../models/category");
const User = require("../models/user");
const { authenticateToken } = require("./userAuth");

// Middleware to check if user is admin
const checkAdmin = async (req, res, next) => {
  const { id } = req.headers; // Get the user ID from headers
  const user = await User.findById(id);

  if (user.role !== "admin") {
    return res.status(403).json({ message: "You do not have admin access" });
  }

  next(); // Continue if the user is admin
};

// Add a new category (Admin only)
router.post(
  "/add-category",
  authenticateToken,
  checkAdmin,
  async (req, res) => {
    try {
      const { name } = req.body;

      // Check if category already exists
      const existingCategory = await Category.findOne({ name });
      if (existingCategory) {
        return res.status(400).json({ message: "Category already exists" });
      }

      // Create a new category
      const category = new Category({ name });
      await category.save();

      res.status(201).json({ message: "Category added successfully" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Internal server error" });
    }
  }
);

// Get all categories
router.get("/get-all-categories", async (req, res) => {
  try {
    const categories = await Category.find().sort({ createdAt: -1 });
    return res.status(200).json({
      status: "Success",
      data: categories,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// Delete a category (Admin only)
router.delete(
  "/delete-category/",
  authenticateToken,
  checkAdmin,
  async (req, res) => {
    try {
      const { categoryId } = req.query;

      // Find and delete the category by ID
      const category = await Category.findByIdAndDelete(categoryId);

      if (!category) {
        return res.status(404).json({ message: "Category not found" });
      }

      res.status(200).json({ message: "Category deleted successfully" });
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "An error occurred" });
    }
  }
);

// Update a category (Admin only)
router.put(
  "/update-category/:id",
  authenticateToken,
  checkAdmin,
  async (req, res) => {
    try {
      const { id } = req.params; // Get category ID from URL params
      const { name } = req.body;

      // Find and update the category
      const category = await Category.findByIdAndUpdate(
        id,
        { name },
        { new: true }
      );

      if (!category) {
        return res.status(404).json({ message: "Category not found" });
      }

      res
        .status(200)
        .json({ message: "Category updated successfully", category });
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "An error occurred" });
    }
  }
);

module.exports = router;
