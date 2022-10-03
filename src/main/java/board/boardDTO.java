package board;

public class boardDTO {   
	
    private String bid;
    private String title;
    private String content;
    private String birth;
    private String likeCount;
    private String photo;
    private String id;
    
   public String getBid() {
      return bid;
   }
   public void setBid(String bid) {
      this.bid = bid;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title = title;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getBirth() {
      return birth;
   }
   public void setBirth(String birth) {
      this.birth = birth;
   }
   public String getLikeCount() {
      return likeCount;
   }
   public void setLikeCount(String likeCount) {
      this.likeCount = likeCount;
   }
   public String getPhoto() {
      return photo;
   }
   public void setPhoto(String photo) {
      this.photo = photo;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
}