package com.projet.jee.dto;


import com.projet.jee.model.Role;
import java.io.Serializable;

public class SessionUser implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
    private String email;
    private Role role;
    private String photo_profile;

    public SessionUser(int id, String email, Role role,String photo_profile) {
        this.id = id; this.email = email; this.role = role; this.photo_profile=photo_profile;
    }
    public int getId() { return id; }
    public String getEmail() { return email; }
    public Role getRole() { return role; }
    public String getPhotoProfile() {return photo_profile;}
}
