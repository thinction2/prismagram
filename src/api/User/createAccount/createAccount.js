import { prisma } from "../../../server";

export default {
  Mutation: {
    createAccount: async (_, args) => {
      const {
        username,
        email,
        firstName = "",
        lastName = "",
        bio = "",
        loginSecret = "",
      } = args;
      return await prisma.user.create({
        data: { username, email, firstName, lastName, bio, loginSecret },
      });
    },
  },
};
