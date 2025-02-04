const router = require("express").Router();
const { authenticateToken } = require("./userAuth");
const Dessert = require("../models/dessert");
const Order = require("../models/order");
const User = require("../models/user");

//place order
router.post("/place-order", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers;
    const { order } = req.body;

    for (const orderData of order) {
      const newOrder = new Order({ user: id, dessert: orderData._id });
      const orderDataFromDb = await newOrder.save();

      //saving order in user model
      await User.findByIdAndUpdate(id, {
        $push: { orders: orderDataFromDb._id },
      });

      //cleaning cart
      await User.findByIdAndUpdate(id, {
        $pull: { cart: orderData._id },
      });
    }
    return res.json({
      status: "success",
      message: "Order placed successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

//get order history of particular user
router.get("/get-order-history", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers;

    // const user = await User.findById(id);
    // if (user.role !== "admin") {
    //   return res
    //     .status(400)
    //     .json({ message: "You dont have access to perform this task" });
    // }

    OrdersData = await Order.find({ user: id }).populate("dessert");

    return res.json({
      status: "Success",
      data: OrdersData,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

//get all orders --admin
router.get("/get-all-orders", authenticateToken, async (req, res) => {
  try {
    const { id } = req.headers;

    const user = await User.findById(id);
    if (user.role !== "admin") {
      return res
        .status(400)
        .json({ message: "You dont have access to perform this task" });
    }

    const userData = await Order.find()
      .populate({
        path: "dessert",
      })
      .populate({
        path: "user",
      })
      .sort({ createdAt: -1 });

    return res.json({
      status: "Success",
      data: userData,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

// update order --admin
router.put("/update-status", authenticateToken, async (req, res) => {
  try {

    const { orderId } = req.query;
    await Order.findByIdAndUpdate(orderId, { status: req.body.status });

    return res.json({
      status: "Success",
      message: "Status Updated Successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "An error occurred" });
  }
});

module.exports = router;
