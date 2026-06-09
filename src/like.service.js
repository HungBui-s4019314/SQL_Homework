import prisma from "../common/prisma/connect.prisma.js";

// Like a restaurant
const likeRestaurant = async (userId, resId) => {
  return prisma.like_res.create({
    data: {
      user_id: userId,
      res_id: resId,
    },
  });
};

// Unlike a restaurant
const unlikeRestaurant = async (userId, resId) => {
  return prisma.like_res.delete({
    where: {
      user_id_res_id: {
        user_id: userId,
        res_id: resId,
      },
    },
  });
};

// Get all likes by restaurant
const getLikesByRestaurant = async (resId) => {
  return prisma.like_res.findMany({
    where: { res_id: resId },
  });
};

// Get all likes by user
const getLikesByUser = async (userId) => {
  return prisma.like_res.findMany({
    where: { user_id: userId },
  });
};

export default {
  likeRestaurant,
  unlikeRestaurant,
  getLikesByRestaurant,
  getLikesByUser,
};
