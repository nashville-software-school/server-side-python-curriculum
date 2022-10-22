# Override User Serialization

1. By default, only foreign key is included on customer and employee.
2. Expand the related user by specifying the needed fields in a new serializer.
3. Update customer/employee serializer to use the new one for the `user` field.