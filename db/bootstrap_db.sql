CREATE TABLE temp
(first_name varchar,
  last_name varchar,
  email varchar,
  family_invite varchar,
  invitation_to varchar,
  address_line1 varchar,
  address_line2 varchar,
  city varchar,
  state varchar,
  zipcode varchar,
  relationship int,
  tier int,
  code varchar);

COPY temp FROM '/Users/jessica_tai/Downloads/2017_02_22_wedding_all.csv' DELIMITER ','  HEADER CSV;

INSERT INTO user_groups (code, address_line1, address_line2, city, state, zipcode, tier, family_invite)
SELECT code, address_line1, address_line2, city, state, zipcode, tier, family_invite
FROM temp
WHERE invitation_to IS NOT NULL;

INSERT INTO users (first_name, last_name, email, relationship)
SELECT first_name, last_name, email, relationship
FROM   temp
WHERE  last_name IS NOT NULL;

UPDATE users u
SET    user_group_id = ug.id
FROM  user_groups ug
  JOIN temp t
  ON ug.family_invite = t.family_invite
WHERE t.first_name = u.first_name AND t.last_name = u.last_name;
