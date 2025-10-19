package com.projet.jee.service;

import com.projet.jee.model.Service;
import com.projet.jee.model.Fonctionnalite;
import com.projet.jee.model.ServicePhoto;
import com.projet.jee.dao.MyServiceRepository;

import java.util.List;

public class ServiceService {

    private final MyServiceRepository repository = new MyServiceRepository();

    public void addService(Service service, List<Fonctionnalite> features, List<ServicePhoto> photos) {
        repository.saveServiceWithDetails(service, features, photos);
    }

    public List<Service> getAllServices() {
        return repository.findAll();
    }

    public Service getServiceById(int id) {
        return repository.findById(id);
    }
}
