import "dotenv/config";
import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";

import APP_CONSTANT from "./src/common/constant/app.constant.js";
import rootRouter from "./src/routers/root.router.js";

const app = express();

//Middleware
app.use(cors({ origin: "http://localhost:5173", credentials: true }));
app.use(express.json());
app.use(cookieParser(APP_CONSTANT.COOKIE_SECRET));

// Routes
app.use("/api", rootRouter);

//Error handler (must be last)
app.use((err, req, res, next) => {
  console.error(err.message);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || "Internal server error",
  });
});

//Start
app.listen(APP_CONSTANT.PORT, () => {
  console.log(`Server running on port ${APP_CONSTANT.PORT}`);
});
