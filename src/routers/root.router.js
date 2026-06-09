import { Router } from "express";
import likeRouter from "./like.router.js";
import rateRouter from "./rate.router.js";
import orderRouter from "./order.router.js";

const router = Router();

router.use("/likes",   likeRouter);
router.use("/ratings", rateRouter);
router.use("/orders",  orderRouter);

export default router;
