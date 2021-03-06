<cfoutput>
<div class="row-fluid">
    #html.startForm( action=prc.xehMenuSave, name="menuForm", novalidate="novalidate", class="form-vertical" )#
    <div class="span9" id="main-content">
        <div class="box">
            <!--- Body Header --->
            <div class="header">
                <i class="icon-sort-by-attributes-alt icon-large"></i>
                Menu Designer
                <!--- Quick Actions --->
                <div class="btn-group pull-right" style="margin-top:5px">
                    <a class="btn btn-inverse" onclick="window.location.href='#event.buildLink( prc.xehMenus )#';return false;"><i class="icon-reply"></i> Back</a>
                </div>
            </div>
            <!--- Body --->
            <div class="body">
                <!--- MessageBox --->
                #getPlugin( "MessageBox" ).renderit()#
                <menu class="well well-small">
                    <p>Click any of the options below to insert a new menu item of that type.</p>
                    <cfloop collection="#prc.providers#" item="provider">
                        <a class="btn btn-small provider btn-info" data-provider="#provider#"><span style="display:inline-block;" title="#prc.providers[ provider].getDescription()#"><i class="#prc.providers[ provider].getIconClass()#"></i> #provider#</span></a>
                    </cfloop>
                    <a class="btn btn-small pull-right" data-action="collapse-all"><span style="display:inline-block;" title="Collapse All"><i class="icon-minus"></i> Collapse All</span></a>
                    <a class="btn btn-small pull-right" data-action="expand-all" style="margin-right:4px;"><span style="display:inline-block;" title="Expand All"><i class="icon-plus"></i> Expand All</span></a>
                </menu>
                <div class="row-fluid">
                    <span class="span7">
                        <h3>Menu Sandbox</h3>
                        <p>Insert new menu items and then drag-and-drop to get them in the perfect order.</p>
                        <div class="alert alert-error" id="menuErrors" style="display:none;">
                            Uh oh, looks like one (or more) of your menu items is incomplete. Please complete all items and then try again.
                        </div>
                        <div class="designer well well-small">
                            <div class="dd" id="nestable">
                                <ol class="dd-list">
                                    #prc.menuItems#
                                    <div id="placeholder-message">You haven't added any menu items yet. Click on one of the menu types above to get started.</div>
                                </ol>
                            </div>
                        </div>
                    </span>
                    <span class="span5">
                        <h3>Preview <a class="btn btn-small" id="preview-button"><i class="icon-refresh"></i></a></h3>
                        <p>Here's an instant preview of your menu.</p>
                        <div id="preview-panel" class="well well-small">No Preview Available</div>
                    </span>
                </div>
            </div>
        </div>
        
    </div>
    <!--- main sidebar --->
    <div class="span3" id="main-sidebar">
        <!--- Info Box --->
        <div class="small_box">
            <div class="header">
                <i class="icon-cogs"></i> Menu Data
            </div>
            <div class="body">
                <!--- id --->
                #html.hiddenField( name="menuID", bind=prc.menu )#
                #html.hiddenField( name="menuItems" )#      
                <!--- title --->
                #html.textfield(
                    label="Title:",
                    name="title",
                    bind=prc.menu, 
                    maxlength="100",
                    required="required",
                    title="The title for this menu",
                    class="textfield input-block-level",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.select(
                    options="ul,ol", 
                    name="listType",
                    label="List Type:",
                    bind=prc.menu,
                    required="required",
                    title="Select the type of list (ordered or unordered)",
                    class="textfield input-block-level",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                <div class="control-group">
                    <label for="slug" class="control-label">Menu Slug:</label>
                    <div class="controls">
                        <div id='slugCheckErrors'></div>
                        <div class="input-append input-block-level">
                            #html.textfield(name="slug",value=prc.menu.getSlug(),maxlength="100",class="textfield input-block-level",title="The unique slug for this menu", disabled="#prc.menu.isLoaded() ? 'true' : 'false'#")#
                            <a title="" class="btn add-on" href="javascript:void(0)" onclick="toggleSlug(); return false;" data-original-title="Lock/Unlock Menu Slug">
                                <i id="toggleSlug" class="icon-#prc.menu.isLoaded() ? 'lock' : 'unlock'#"></i>
                            </a>
                        </div>
                    </div>
                </div>
                #html.textfield(
                    label="CSS Classes:",
                    name="menuClass",
                    bind=prc.menu, 
                    maxlength="100",
                    title="Additional CSS classes to use for the main menu HTML element",
                    class="textfield input-block-level",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="List CSS Classes:",
                    name="listClass",
                    bind=prc.menu, 
                    maxlength="100",
                    title="CSS classes to apply to all list elements (ul/ol) within this menu",
                    class="textfield input-block-level",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                <div class="actionBar">
                    <a class="btn btn-danger" id="submitMenu">Save Menu</a>
                </div>
            </div>
        </div>
    </div>
    #html.endForm()#
</div>

<!--- CONTEXT MENU TEMPLATE --->
<div id="context-menu" class="dropdown clearfix" style="position: absolute;display:none;">
    <ul class="dropdown-menu" role="menu" style="display:block;margin-bottom:5px;">
        <cfloop collection="#prc.providers#" item="provider">
            <li>
                <a tabindex="-1" class="child-provider" data-provider="#provider#" title="#prc.providers[ provider].getDescription()#">
                    <i class="#prc.providers[ provider].getIconClass()#"></i> Add #provider# Item
                </a>
            </li>
        </cfloop>
  </ul>
</div>

<!--- PREVIEW DIALOG --->
<div id="previewDialog" class="modal hide fade">
    <div id="modalContent">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3><i class="icon-eye-open"></i> Menu Preview</h3>
        </div>
        <div class="modal-body"></div>
    </div>
</div>
</cfoutput>