const router = require("express").Router();
const User = require("../models/user");
const { authenticateToken } = require("./userAuth");

// put dessert to cart
router.put("/add-to-cart", authenticateToken, async (req, res) => {
  try {
    const { dessertId, id } = req.headers;
    const userData = await User.findById(id);
    const isDessertInCart = userData.cart.includes(dessertId);

    if (isDessertInCart) {
      return res.json({
        status: "Success",
        message: "Cake is already in cart",
      });
    }

    await User.findByIdAndUpdate(id, {
      $push: { cart: dessertId },
    });

    return res.json({
      status: "Success",
      message: "Cake added to cart",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// remove from cart
router.put("/remove-from-cart/:dessertId", authenticateToken, async (req, res) => {
  try {
    const { dessertId } = req.params;
    const { id } = req.headers;
    
    await User.findByIdAndUpdate(id, {
      $pull: { cart: dessertId },
    });

    return res.json({
      status: "Success",
      message: "Cake removed from cart",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// get cart of a particular user
router.get("/get-user-cart", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers;
    const userData = await User.findById(id).populate("cart");
    const cart = userData.cart.reverse();

    return res.json({
      status: "Success",
      data: cart,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

module.exports = router;