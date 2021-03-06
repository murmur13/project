package eCare.model.DAO;

import eCare.model.PO.UserProfile;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by echerkas on 15.11.2017.
 */
@Service
public interface UserProfileDao {

    List<UserProfile> findAll();

    UserProfile findByType(String type);

    UserProfile findById(int id);
}
