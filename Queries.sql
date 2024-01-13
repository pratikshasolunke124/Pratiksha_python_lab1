-- --------------------- Question 4 --------------------- --
select count(cus_name) as 'Total Customers' , cus_gender as Gender from (
select * from (
select C.CUS_NAME, C.CUS_GENDER, O.* from customer c
inner join 
`order` o on c.CUS_ID = o.cus_id
where o.ord_amount >= 3000
) as CO
group by CO.cus_name
) as CO2
group by cus_gender;

-- --------------------- Question 5 --------------------- --
select o.cus_id as Customer_id, p.pro_name as Product_name, o.ord_id as Order_id, 
o.ord_amount as Order_amount, o.ord_date as Order_date, o.pricing_id as Pricing_id
from `order` o
inner join supplier_pricing sp
on o.PRICING_ID = sp.PRICING_ID
inner join product p
on p.PRO_ID = sp.pro_id
where o.CUS_ID = 2;

-- --------------------- Question 6 --------------------- --
select * from supplier where supp_id in(
select supp_id
from supplier_pricing sp 
group by supp_id
having count(supp_id) > 1
);

-- --------------------- Question 7 --------------------- --
select c.cat_id as Category_id, c.cat_name as Category_name, p.pro_name as Product_name, sp.Price_of_product
from category c
inner join  product p on c.cat_id = p.cat_id
inner join  (
    select c.cat_id, MIN(sp.supp_price) as Price_of_product
    from category c
    inner join product p on c.cat_id = p.cat_id
    inner join supplier_pricing sp on p.pro_id = sp.pro_id
    group by c.cat_id
) sp on c.cat_id = sp.cat_id
inner join supplier_pricing sp2 on p.pro_id = sp2.pro_id 
AND sp.Price_of_product = sp2.supp_price
order by c.cat_id asc;

-- --------------------- Question 8 --------------------- --
select p.PRO_ID as Product_id , p.PRO_NAME as Product_name,o.ORD_DATE as Order_Date
from product p
inner join supplier_pricing sp
on p.PRO_ID = sp.pro_ID
inner join `order` o
on sp.PRICING_ID = o.PRICING_ID
where o.ORD_DATE > "2021-10-05"; 

-- --------------------- Question 9 --------------------- --
select cus_name as Customer_name, cus_gender as Gender from customer 
where cus_name like 'A%' or cus_name like '%A' ;

-- --------------------- Question 10 --------------------- --
select SP_RO2.supp_id AS Supplier_id, S.supp_name as Name, SP_RO2.Rating,

case
	when Rating = 5 then 'Excellent Service'
	when Rating > 4 then 'Good Service'    
	when Rating > 2 then 'Average Service'    
    else 'Poor Service'
end as 'TypeOfService'

from supplier S inner join(
select supp_id, avg(rat_ratstars) as Rating from (
select SP.supp_id, RO.rat_ratstars 
from supplier_pricing SP inner join(
select O.pricing_id, R.rat_ratstars from `order` O
inner join rating R
on R.ord_id = O.ord_id
)as RO
on SP.pricing_id = RO.pricing_id
)as SP_RO
group by supp_id
) as SP_RO2
on S.supp_id = SP_RO2.supp_id;
