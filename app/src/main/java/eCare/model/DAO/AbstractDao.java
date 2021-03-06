package eCare.model.DAO;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

/**
 * Created by echerkas on 15.11.2017.
 */
public abstract class AbstractDao <PK extends Serializable, T> {

        private Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public AbstractDao(){
            this.persistentClass =(Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments()[1];
        }

        @Autowired
        private SessionFactory sessionFactory;

    protected Session getSession(){
        return sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    public T getByKey(PK key) {
        return (T) getSession().get(persistentClass, key);
    }

    public void persist(T entity) {
        getSession().persist(entity);
    }

    public void update(T entity) {
        getSession().update(entity);
    }

    public void delete(T entity) {
        getSession().delete(entity);
    }

//    //Open Session
//    Session session = sessionFactory.openSession();
//
//    //Get Criteria Builder
//    CriteriaBuilder builder = session.getCriteriaBuilder();
//
//    //Create Criteria
//    CriteriaQuery<T> criteria = builder.createQuery(persistentClass);


    protected Criteria createEntityCriteria(){
        return getSession().createCriteria(persistentClass);
    }
}
