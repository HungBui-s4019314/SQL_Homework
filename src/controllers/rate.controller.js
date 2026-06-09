import rateService from "../services/rate.service.js";
import responseHelper from "../common/helpers/response.helper.js";

const { responseSuccess } = responseHelper;

const rateRestaurant = async (req, res, next) => {
  try {
    const resId = parseInt(req.params.resId);
    const userId = parseInt(req.body.user_id);
    const amount = parseInt(req.body.amount);
    const data = await rateService.rateRestaurant(userId, resId, amount);
    responseSuccess(res, data, 201);
  } catch (err) {
    next(err);
  }
};

const getRatingsByRestaurant = async (req, res, next) => {
  try {
    const resId = parseInt(req.params.resId);
    const data = await rateService.getRatingsByRestaurant(resId);
    responseSuccess(res, data);
  } catch (err) {
    next(err);
  }
};

const getRatingsByUser = async (req, res, next) => {
  try {
    const userId = parseInt(req.params.userId);
    const data = await rateService.getRatingsByUser(userId);
    responseSuccess(res, data);
  } catch (err) {
    next(err);
  }
};

export default {
  rateRestaurant,
  getRatingsByRestaurant,
  getRatingsByUser,
};
