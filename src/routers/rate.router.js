import { Router } from "express";
import rateController from "../controllers/rate.controller.js";

const router = Router();

router.post("/:resId", rateController.rateRestaurant);
router.get("/restaurant/:resId", rateController.getRatingsByRestaurant);
router.get("/user/:userId", rateController.getRatingsByUser);

export default router;
