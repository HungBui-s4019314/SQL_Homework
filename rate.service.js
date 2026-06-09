import prisma from "../common/prisma/connect.prisma.js";

// Add or update a rating (upsert: update if exists, create if not)
const rateRestaurant = async (userId, resId, amount) => {
  return prisma.rate_res.upsert({
    where: {
      user_id_res_id: {
        user_id: userId,
        res_id: resId,
      },
    },
    update: { amount },
    create: {
      user_id: userId,
      res_id: resId,
      amount,
    },
  });
};

// Get all ratings by restaurant
const getRatingsByRestaurant = async (resId) => {
  return prisma.rate_res.findMany({
    where: { res_id: resId },
  });
};

// Get all ratings by user
const getRatingsByUser = async (userId) => {
  return prisma.rate_res.findMany({
    where: { user_id: userId },
  });
};

export default {
  rateRestaurant,
  getRatingsByRestaurant,
  getRatingsByUser,
};
