require("dotenv").config();
import { GraphQLServer } from "graphql-yoga";
import logger from "morgan";
import schema from "./schema";
import { PrismaClient } from "@prisma/client";

const PORT = process.env.PORT || 4000;
export const prisma = new PrismaClient();

const server = new GraphQLServer({ schema });

server.express.use(logger("dev"));

server.start({ port: PORT }, () =>
  console.log(`✅ Server running on port ${PORT}`)
);
