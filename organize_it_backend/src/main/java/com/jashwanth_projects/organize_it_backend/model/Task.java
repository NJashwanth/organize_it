package com.jashwanth_projects.organize_it_backend.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;




 
@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "tasks") 
public class Task {
    @Id
    private String id;
    private String title;
    private String description;
    private boolean completed;   
    private String priority;
}
