import { AuthPage } from "@components/auth-page";
import { authProviderServer } from "@providers/auth-provider";
import { redirect } from "next/navigation";
import { NewsBot } from "../../../../news-bot/bot";

export default async function Login() {
  const data = await getData();

  // if (data.authenticated) {
  //   redirect(data?.redirectTo || "/");
  // }

  NewsBot.instance.on("custom", (resp) => {
    console.log(resp);
  });

  NewsBot.instance.emit("start");

  return <AuthPage type="login" />;
}

async function getData() {
  const { authenticated, redirectTo, error } = await authProviderServer.check();

  return {
    authenticated,
    redirectTo,
    error,
  };
}
