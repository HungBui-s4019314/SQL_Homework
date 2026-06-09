import prisma from "../common/prisma/connect.prisma.js";

// Generate a unique order code
const generateCode = () => `ORD-${Date.now()}`;

// Create a new order (with optional sub_food items)
const createOrder = async (userId, foodId, amount, subIds = []) => {
  return prisma.order.create({
    data: {
      user_id: userId,
      food_id: foodId,
      amount,
      code: generateCode(),
      // If subIds provided, create order_sub records
      order_sub: subIds.length > 0
        ? {
            create: subIds.map((subId) => ({ sub_id: subId })),
          }
        : undefined,
    },
    include: {
      order_sub: true,
    },
  });
};

// Get all orders by user
const getOrdersByUser = async (userId) => {
  return prisma.order.findMany({
    where: { user_id: userId },
    include: {
      food: true,
      order_sub: {
        include: { sub_food: true },
      },
    },
  });
};

export default {
  createOrder,
  getOrdersByUser,
};
