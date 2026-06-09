import { Router } from "express";
import likeController from "../controllers/like.controller.js";

const router = Router();

router.post("/:resId", likeController.likeRestaurant);
router.delete("/:resId", likeController.unlikeRestaurant);
router.get("/restaurant/:resId", likeController.getLikesByRestaurant);
router.get("/user/:userId", likeController.getLikesByUser);

export default router;
