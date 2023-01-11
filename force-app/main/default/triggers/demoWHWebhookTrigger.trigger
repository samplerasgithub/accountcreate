trigger demoWHWebhookTrigger on Account (after insert,after update, after delete) {

    String url = 'https://echo-webhook.herokuapp.com/foo';

    String content = Webhook.jsonContent(Trigger.new, Trigger.old);

    Webhook.callout(url, content);

}