import likeService from "../services/like.service.js";
import responseHelper from "../common/helpers/response.helper.js";

const { responseSuccess, responseError } = responseHelper;

const likeRestaurant = async (req, res, next) => {
  try {
    const resId = parseInt(req.params.resId);
    const userId = parseInt(req.body.user_id);
    const data = await likeService.likeRestaurant(userId, resId);
    responseSuccess(res, data, 201);
  } catch (err) {
    next(err);
  }
};

const unlikeRestaurant = async (req, res, next) => {
  try {
    const resId = parseInt(req.params.resId);
    const userId = parseInt(req.body.user_id);
    await likeService.unlikeRestaurant(userId, resId);
    responseSuccess(res, { message: "Unliked successfully" });
  } catch (err) {
    next(err);
  }
};

const getLikesByRestaurant = async (req, res, next) => {
  try {
    const resId = parseInt(req.params.resId);
    const data = await likeService.getLikesByRestaurant(resId);
    responseSuccess(res, data);
  } catch (err) {
    next(err);
  }
};

const getLikesByUser = async (req, res, next) => {
  try {
    const userId = parseInt(req.params.userId);
    const data = await likeService.getLikesByUser(userId);
    responseSuccess(res, data);
  } catch (err) {
    next(err);
  }
};

export default {
  likeRestaurant,
  unlikeRestaurant,
  getLikesByRestaurant,
  getLikesByUser,
};
