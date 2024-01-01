defmodule App.Quiz do
  @moduledoc """
  The Quiz context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Quiz.Story
  alias App.Quiz.CompletedStory
  alias App.Quiz.McqAnswer

  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """
  def list_stories do
    Repo.all(Story)
  end

  def list_stories_ids do
    Repo.all(from s in Story, select: s.id)
  end

  def list_user_stories(user_id) do
    from(s in CompletedStory, where: s.user_id == ^user_id)
    |> Repo.all()
    |> Repo.preload(:story)
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(id), do: Repo.get!(Story, id)

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{data: %Story{}}

  """
  def change_story(%Story{} = story, attrs \\ %{}) do
    Story.changeset(story, attrs)
  end

  alias App.Quiz.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def get_answers_of_mcq(mcq_id) do
    from(m in McqAnswer, where: m.mcq_id == ^mcq_id)
    |> Repo.all()
    |> Repo.preload(:mcq)
  end

  def is_mcq_answer_correct(id) do
    from(m in McqAnswer, where: m.id == ^id, select: m.is_correct)
    |> Repo.one()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias App.Quiz.Answer

  @doc """
  Returns the list of answers.

  ## Examples

      iex> list_answers()
      [%Answer{}, ...]

  """
  def list_answers do
    Repo.all(Answer)
  end

  @doc """
  Gets a single answer.

  Raises `Ecto.NoResultsError` if the Answer does not exist.

  ## Examples

      iex> get_answer!(123)
      %Answer{}

      iex> get_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_answer!(id), do: Repo.get!(Answer, id)

  @doc """
  Creates a answer.

  ## Examples

      iex> create_answer(%{field: value})
      {:ok, %Answer{}}

      iex> create_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_answer(attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a answer.

  ## Examples

      iex> update_answer(answer, %{field: new_value})
      {:ok, %Answer{}}

      iex> update_answer(answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_answer(%Answer{} = answer, attrs) do
    answer
    |> Answer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a answer.

  ## Examples

      iex> delete_answer(answer)
      {:ok, %Answer{}}

      iex> delete_answer(answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_answer(%Answer{} = answer) do
    Repo.delete(answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.

  ## Examples

      iex> change_answer(answer)
      %Ecto.Changeset{data: %Answer{}}

  """
  def change_answer(%Answer{} = answer, attrs \\ %{}) do
    Answer.changeset(answer, attrs)
  end

  def get_answers_of_question(question_id) do
    Repo.all(from a in Answer,
      where: a.question_id == ^question_id)
  end

  def get_questions_of_story(story_id) do
    Repo.all(from q in Question,
      where: q.story_id == ^story_id,
      select: q.id)
  end


  alias App.Quiz.CompletedStory

  @doc """
  Returns the list of completed_stories.

  ## Examples

      iex> list_completed_stories()
      [%CompletedStory{}, ...]

  """
  def list_completed_stories do
    Repo.all(CompletedStory)
  end

  @doc """
  Gets a single completed_story.

  Raises `Ecto.NoResultsError` if the Completed story does not exist.

  ## Examples

      iex> get_completed_story!(123)
      %CompletedStory{}

      iex> get_completed_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_completed_story!(id), do: Repo.get!(CompletedStory, id)

  @doc """
  Creates a completed_story.

  ## Examples

      iex> create_completed_story(%{field: value})
      {:ok, %CompletedStory{}}

      iex> create_completed_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_completed_story(attrs \\ %{}) do
    %CompletedStory{}
    |> CompletedStory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a completed_story.

  ## Examples

      iex> update_completed_story(completed_story, %{field: new_value})
      {:ok, %CompletedStory{}}

      iex> update_completed_story(completed_story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_completed_story(%CompletedStory{} = completed_story, attrs) do
    completed_story
    |> CompletedStory.changeset(attrs)
    |> Repo.update()
  end

  def get_completed_story_by_user_id_and_story_id(user_id, story_id) do
    Repo.one(from c in CompletedStory,
      where: c.user_id == ^user_id and c.story_id == ^story_id)
  end

  @doc """
  Deletes a completed_story.

  ## Examples

      iex> delete_completed_story(completed_story)
      {:ok, %CompletedStory{}}

      iex> delete_completed_story(completed_story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_completed_story(%CompletedStory{} = completed_story) do
    Repo.delete(completed_story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking completed_story changes.

  ## Examples

      iex> change_completed_story(completed_story)
      %Ecto.Changeset{data: %CompletedStory{}}

  """
  def change_completed_story(%CompletedStory{} = completed_story, attrs \\ %{}) do
    CompletedStory.changeset(completed_story, attrs)
  end

  alias App.Quiz.Mcq

  @doc """
  Returns the list of mcqs.

  ## Examples

      iex> list_mcqs()
      [%Mcq{}, ...]

  """
  def list_mcqs do
    Repo.all(Mcq)
  end


  @doc """
  Gets a single mcq.

  Raises `Ecto.NoResultsError` if the Mcq does not exist.

  ## Examples

      iex> get_mcq!(123)
      %Mcq{}

      iex> get_mcq!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mcq!(id), do: Repo.get!(Mcq, id)

  @doc """
  Creates a mcq.

  ## Examples

      iex> create_mcq(%{field: value})
      {:ok, %Mcq{}}

      iex> create_mcq(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mcq(attrs \\ %{}) do
    %Mcq{}
    |> Mcq.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mcq.

  ## Examples

      iex> update_mcq(mcq, %{field: new_value})
      {:ok, %Mcq{}}

      iex> update_mcq(mcq, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mcq(%Mcq{} = mcq, attrs) do
    mcq
    |> Mcq.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mcq.

  ## Examples

      iex> delete_mcq(mcq)
      {:ok, %Mcq{}}

      iex> delete_mcq(mcq)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mcq(%Mcq{} = mcq) do
    Repo.delete(mcq)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mcq changes.

  ## Examples

      iex> change_mcq(mcq)
      %Ecto.Changeset{data: %Mcq{}}

  """
  def change_mcq(%Mcq{} = mcq, attrs \\ %{}) do
    Mcq.changeset(mcq, attrs)
  end

  alias App.Quiz.McqAnswer

  @doc """
  Returns the list of mcqs_answers.

  ## Examples

      iex> list_mcqs_answers()
      [%McqAnswer{}, ...]

  """
  def list_mcqs_answers do
    Repo.all(McqAnswer)
  end

  @doc """
  Gets a single mcq_answer.

  Raises `Ecto.NoResultsError` if the Mcq answer does not exist.

  ## Examples

      iex> get_mcq_answer!(123)
      %McqAnswer{}

      iex> get_mcq_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mcq_answer!(id), do: Repo.get!(McqAnswer, id)

  @doc """
  Creates a mcq_answer.

  ## Examples

      iex> create_mcq_answer(%{field: value})
      {:ok, %McqAnswer{}}

      iex> create_mcq_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mcq_answer(attrs \\ %{}) do
    %McqAnswer{}
    |> McqAnswer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mcq_answer.

  ## Examples

      iex> update_mcq_answer(mcq_answer, %{field: new_value})
      {:ok, %McqAnswer{}}

      iex> update_mcq_answer(mcq_answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mcq_answer(%McqAnswer{} = mcq_answer, attrs) do
    mcq_answer
    |> McqAnswer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mcq_answer.

  ## Examples

      iex> delete_mcq_answer(mcq_answer)
      {:ok, %McqAnswer{}}

      iex> delete_mcq_answer(mcq_answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mcq_answer(%McqAnswer{} = mcq_answer) do
    Repo.delete(mcq_answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mcq_answer changes.

  ## Examples

      iex> change_mcq_answer(mcq_answer)
      %Ecto.Changeset{data: %McqAnswer{}}

  """
  def change_mcq_answer(%McqAnswer{} = mcq_answer, attrs \\ %{}) do
    McqAnswer.changeset(mcq_answer, attrs)
  end
end
