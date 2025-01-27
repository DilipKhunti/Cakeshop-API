const router = require("express").Router();
const User = require("../models/user");
const { authenticateToken } = require("./userAuth");

//add dessert to favorites
router.put("/add-dessert-to-favourite", authenticateToken, async (req, res) => {
  try {
    const { dessertId, id } = req.headers;
    const userData = await User.findById(id);
    const isDessertFavourite = userData.favourites.includes(dessertId);

    if (isDessertFavourite) {
      return res.status(200).json({ message: "Dessert is already in favourites" });
    }

    await User.findByIdAndUpdate(id, { $push: { favourites: dessertId } });
    return res.status(200).json({ message: "Dessert added to favourites" });
  } catch (error) {
    res.status(500).json({ message: "Internal server error" });
  }
});

// Remove dessert from favourites
router.put(
  "/remove-dessert-from-favourite",
  authenticateToken,
  async (req, res) => {
    try {
      const { dessertId, id } = req.headers;
      const userData = await User.findById(id);
      const isDessertFavourite = userData.favourites.includes(dessertId);

      if (!isDessertFavourite) {
        return res.status(200).json({ message: "Dessert is not in favourites" });
      }

      await User.findByIdAndUpdate(id, { $pull: { favourites: dessertId } });

      return res.status(200).json({ message: "Dessert removed from favourites" });
    } catch (error) {
      res.status(500).json({ message: "Internal server error" });
    }
  }
);

// get Favourite desserts of a particular user
router.get("/get-favourite-desserts", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers;
    const userData = await User.findById(id).populate("favourites");
    const favouriteBooks = userData.favourites;

    return res.json({
      status: "Success",
      data: favouriteBooks,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

module.exports = router;
