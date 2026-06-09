const APP_CONSTANT = {
  PORT: process.env.PORT || 3000,
  COOKIE_SECRET: process.env.COOKIE_SECRET || "mySecretKey",
  COOKIE_MAX_AGE: 24 * 60 * 60 * 1000, // 1 day
};

export default APP_CONSTANT;
