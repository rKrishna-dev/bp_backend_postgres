import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

// sign in
export const comparePasswords = (password, hash) => {
  return bcrypt.compare(password, hash);
};

//hashPassword
export const hashPassword = (password) => {
  return bcrypt.hash(password, 5);
};

export const createJWT = (user) => {
  const token = jwt.sign(
    { id: user.id, username: user.username },
    process.env.JWT_SECRET
  );
  return token;
};

export const protect = (req, res, next) => {
  const bearer = req.headers.authorization;
  if (!bearer) {
    res.status(401);
    res.send("Not authorized");
    return;
  }
  const [, token] = bearer.split(" ");
  if (!token) {
    res.status(401);
    res.send("Not authorized");
    return;
  }
  try {
    const user = jwt.verify(token, process.env.JWT_SECRET);
    req.user = user;
    next();
  } catch (error) {
    console.log(error);
    res.status(401);
    res.send("Not authorized");
    return;
  }
};
