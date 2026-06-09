import orderService from "../services/order.service.js";
import responseHelper from "../common/helpers/response.helper.js";

const { responseSuccess } = responseHelper;

const createOrder = async (req, res, next) => {
  try {
    const userId = parseInt(req.body.user_id);
    const foodId = parseInt(req.body.food_id);
    const amount = parseInt(req.body.amount);
    const subIds = req.body.sub_ids || []; // optional array of sub_food ids
    const data = await orderService.createOrder(userId, foodId, amount, subIds);
    responseSuccess(res, data, 201);
  } catch (err) {
    next(err);
  }
};

const getOrdersByUser = async (req, res, next) => {
  try {
    const userId = parseInt(req.params.userId);
    const data = await orderService.getOrdersByUser(userId);
    responseSuccess(res, data);
  } catch (err) {
    next(err);
  }
};

export default {
  createOrder,
  getOrdersByUser,
};
