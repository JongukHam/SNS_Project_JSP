package message;

public class messageDTO {

   private String id;
   private String rid;
   private String message;
   private String date;
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getRid() {
      return rid;
   }
   public void setRid(String rid) {
      this.rid = rid;
   }
   public String getContent() {
      return message;
   }
   public void setContent(String content) {
      this.message = content;
   }
   public String getDate() {
      return date;
   }
   public void setDate(String date) {
      this.date = date;
   }
   
}