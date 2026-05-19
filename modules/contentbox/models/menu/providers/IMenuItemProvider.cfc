/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Interface for menu item providers
 */
interface {

	default public string function getName();

	default public string function getEntityName();

	default public string function getType();

	default public string function getDescription();

	default public string function getAdminTemplate( required any menuItem, required struct options );

	default public string function getDisplayTemplate( required any menuItem, required struct options );
}