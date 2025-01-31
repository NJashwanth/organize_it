package com.jashwanth_projects.organize_it_backend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.jashwanth_projects.organize_it_backend.model.Task;

@Repository
public interface  TaskRepository extends MongoRepository<Task, String> {

}
