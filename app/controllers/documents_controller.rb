class DocumentsController < InheritedResources::Base
  def search
    @documents = Document.basic_search(params[:query])

    respond_to do |format|
      format.html { render :index } # index.html.erb
      format.json { render json: @documents }
    end
  end

  def create
    create! do |format|
      if @document.errors.empty? && @document.extract_content
        format.html { redirect_to documents_path, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update! do |format|
      if @document.errors.empty? && @document.extract_content
        format.html { redirect_to document_path notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def permitted_params
    params.permit(:document => [:title, :doc])
  end
end
